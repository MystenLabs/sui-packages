module 0x84b9de9ea211178211a92d26b196508322ae0ff9d52654446f7aa3fade151011::woody {
    struct WOODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOODY>(arg0, 9, b"WOODY", b"Woodman", x"576f6f646d616e206973206120726573696c69656e742c206e61747572652d696e73706972656420746f6b656e206f6e207468652053554920626c6f636b636861696e2c206f66666572696e67207365637572652c2072656c6961626c65207472616e73616374696f6e732e204974e2809973207065726665637420666f72207573657273207365656b696e6720737472656e67746820616e642073696d706c696369747920696e207468652063727970746f2073706163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1831264203056824320/Rb2-L3rl.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOODY>(&mut v2, 1300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOODY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOODY>>(v1);
    }

    // decompiled from Move bytecode v6
}

