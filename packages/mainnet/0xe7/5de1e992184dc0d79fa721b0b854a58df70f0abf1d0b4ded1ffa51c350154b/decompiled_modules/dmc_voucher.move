module 0xe75de1e992184dc0d79fa721b0b854a58df70f0abf1d0b4ded1ffa51c350154b::dmc_voucher {
    struct DMC_VOUCHER has drop {
        dummy_field: bool,
    }

    struct DmcVoucher has key {
        id: 0x2::object::UID,
        allocation: u16,
        image_uri: 0x1::string::String,
    }

    public(friend) fun new(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : DmcVoucher {
        let v0 = vector[b"fupnlJXv3V3ChQkfPlJunzOIUg49d09ZLEHK6tdsLBI", b"1P4GrTGpKL7r9_3F2YSKdyaz1b5rAEPY_8UagsEzUnQ", b"wiwN5x1Fw0WOJEX0ayRl8hvobE1KZiZiRlVX20APjzg", b"R5npL5ba3LaDJsZ_yGQMyqzdrh-5LA6PKgPJ6m-1KQs", b"1626BJmKboAWtdh6Sfsk_fUMhezpvqrLljdzdCLGc20"];
        let v1 = vector[888, 1888, 2888, 3888, 4888];
        DmcVoucher{
            id         : 0x2::object::new(arg1),
            allocation : *0x1::vector::borrow<u16>(&v1, (arg0 as u64)),
            image_uri  : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, (arg0 as u64))),
        }
    }

    public(friend) fun transfer(arg0: DmcVoucher, arg1: address) {
        0x2::transfer::transfer<DmcVoucher>(arg0, arg1);
    }

    public fun allocation(arg0: &DmcVoucher) : u16 {
        arg0.allocation
    }

    public fun image_uri(arg0: &DmcVoucher) : 0x1::string::String {
        arg0.image_uri
    }

    fun init(arg0: DMC_VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DMC_VOUCHER>(arg0, arg1);
        let v1 = 0x2::display::new<DmcVoucher>(&v0, arg1);
        0x2::display::add<DmcVoucher>(&mut v1, 0x1::string::utf8(b"allocation"), 0x1::string::utf8(b"{allocation}"));
        0x2::display::add<DmcVoucher>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"An NFT airdrop voucher representing a claimable allocation of DeLorean $DMC tokens. Eligible for redemption during the official DeLorean Airdrop Race campaign. Non-transferrable and valid for one-time use only. Claim requires completion of specified quest-based tasks, with additional $DMC rewards unlocked by completing more race laps. Start your engines!"));
        0x2::display::add<DmcVoucher>(&mut v1, 0x1::string::utf8(b"image_uri"), 0x1::string::utf8(b"walrus://{image_uri}"));
        0x2::display::add<DmcVoucher>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://wal.gg/{image_uri}"));
        0x2::display::add<DmcVoucher>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"DeLorean $DMC Airdrop Voucher"));
        0x2::display::update_version<DmcVoucher>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<DmcVoucher>>(v1, @0x4d40228d5e6b4c2f739c73e4e42f751e5a2fef4cd6320c1e3ab91211149ed17b);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0x4d40228d5e6b4c2f739c73e4e42f751e5a2fef4cd6320c1e3ab91211149ed17b);
    }

    // decompiled from Move bytecode v6
}

