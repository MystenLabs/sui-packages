module 0xeea4d31938f38f3c28186526f68e6ad13268922f67e9c5f4c9021853787e7d4c::sample_nft {
    struct SAMPLE_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct SampleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        image_url: 0x1::ascii::String,
    }

    fun init(arg0: SAMPLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<SAMPLE_NFT>(arg0, arg1);
        let v2 = 0x2::display::new<SampleNFT>(&v1, arg1);
        0x2::display::add<SampleNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SampleNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<SampleNFT>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<SampleNFT>(&v1, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<SampleNFT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SampleNFT>>(v4, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SampleNFT>>(v3);
    }

    public fun mint(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) : SampleNFT {
        SampleNFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        }
    }

    public entry fun mint_and_transfer(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<SampleNFT>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::lock<SampleNFT>(arg2, arg3, arg4, mint(arg0, arg1, arg5));
    }

    // decompiled from Move bytecode v6
}

