module 0x243affbeefed14a9634420f35bf5bec51287aa508c432fe40e94940bbe0be382::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"HOPGOAT", x"474f4154206973206e6f74206a75737420616e6f74686572206d656d6520746f6b656e697473206275696c7420666f7220726964696e6720746f2074686520746f70207769746820636f6d6d756e69747920626f6e64696e672c206578636974696e6720726577617264732c20616e64206d756368206d6f72652120576572652074616b696e6720697420737472616967687420746f20746865206865617274206f66205375692c206c61756e6368696e67206578636c75736976656c79206f6e207468652053756920626c6f636b636861696e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gooat_584da73a66.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

