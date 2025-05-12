module 0x8fbe8ebb5d6def67a0c2ab4c8638764a745ff6cd7a8fd3dd86995f5329df0449::haedal {
    struct HAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAEDAL>(arg0, 9, b"HAEDAL", b"Haedal", b"A prime liquid staking protocol on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/Rp80fmqZS3qBDnfyxyKEvc65nVdTunjOG3NY8T6AjpI")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAEDAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HAEDAL>>(0x2::coin::mint<HAEDAL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAEDAL>>(v2);
    }

    // decompiled from Move bytecode v6
}

