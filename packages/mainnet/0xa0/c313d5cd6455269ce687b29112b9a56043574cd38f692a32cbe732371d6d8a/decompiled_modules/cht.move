module 0xa0c313d5cd6455269ce687b29112b9a56043574cd38f692a32cbe732371d6d8a::cht {
    struct CHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHT>(arg0, 6, b"CHT", b"Chuckle Hat", x"436875636b6c6520486174202824434854292069732061206e6577206d656d6520636f696e2070726f6a656374207468617420636f6d62696e6573206d656d652063756c7475726520616e6420626c6f636b636861696e20746563686e6f6c6f67792e0a5468652070726f6a6563742061696d7320746f20637265617465206120756e697175652065636f73797374656d206279206d657267696e67206d656d652063756c7475726520616e6420696e7465726e65742063756c74757265207769746820626c6f636b636861696e20746563686e6f6c6f67792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cht_icon_01_a8991a993f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

