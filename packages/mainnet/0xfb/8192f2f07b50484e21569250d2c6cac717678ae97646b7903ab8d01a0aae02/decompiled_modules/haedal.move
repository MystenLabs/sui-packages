module 0xfb8192f2f07b50484e21569250d2c6cac717678ae97646b7903ab8d01a0aae02::haedal {
    struct HAEDAL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HAEDAL>, arg1: 0x2::coin::Coin<HAEDAL>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<HAEDAL>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAEDAL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HAEDAL>>(0x2::coin::mint<HAEDAL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<HAEDAL>(arg0, 9, b"HAEDAL", b"HAEDAL", x"48414544414c20e280942048616564616c2050726f746f636f6c20746f6b656e206f6e205375692e205374616b696e672026206c6971756964207374616b696e67206d616769632e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/Rp80fmqZS3qBDnfyxyKEvc65nVdTunjOG3NY8T6AjpI")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAEDAL>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<HAEDAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HAEDAL>>(v0);
    }

    // decompiled from Move bytecode v6
}

