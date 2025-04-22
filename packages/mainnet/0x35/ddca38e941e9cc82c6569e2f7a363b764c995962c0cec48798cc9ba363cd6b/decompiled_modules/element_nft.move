module 0x35ddca38e941e9cc82c6569e2f7a363b764c995962c0cec48798cc9ba363cd6b::element_nft {
    struct ElementNFT has store, key {
        id: 0x2::object::UID,
        element_name: 0x1::string::String,
        amount: u64,
        emoji: 0x1::string::String,
        itemId: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ELEMENT_NFT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: ElementNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let ElementNFT {
            id           : v0,
            element_name : _,
            amount       : _,
            emoji        : _,
            itemId       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_amount(arg0: &ElementNFT) : u64 {
        arg0.amount
    }

    public fun get_element_name(arg0: &ElementNFT) : 0x1::string::String {
        arg0.element_name
    }

    public fun get_emoji(arg0: &ElementNFT) : 0x1::string::String {
        arg0.emoji
    }

    public fun get_item_id(arg0: &ElementNFT) : 0x1::string::String {
        arg0.itemId
    }

    fun init(arg0: ELEMENT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ELEMENT_NFT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<ElementNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<ElementNFT>>(v1);
        let v3 = 0x2::display::new<ElementNFT>(&v0, arg1);
        0x2::display::add<ElementNFT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{element_name}"));
        0x2::display::add<ElementNFT>(&mut v3, 0x1::string::utf8(b"emoji"), 0x1::string::utf8(b"{emoji}"));
        0x2::display::add<ElementNFT>(&mut v3, 0x1::string::utf8(b"amount"), 0x1::string::utf8(b"{amount}"));
        0x2::display::add<ElementNFT>(&mut v3, 0x1::string::utf8(b"itemId"), 0x1::string::utf8(b"{itemId}"));
        0x2::display::update_version<ElementNFT>(&mut v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::display::Display<ElementNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<ElementNFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_with_admin(arg0: &AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ElementNFT{
            id           : 0x2::object::new(arg6),
            element_name : arg1,
            amount       : arg2,
            emoji        : arg3,
            itemId       : arg4,
        };
        0x2::transfer::public_transfer<ElementNFT>(v0, arg5);
    }

    // decompiled from Move bytecode v6
}

