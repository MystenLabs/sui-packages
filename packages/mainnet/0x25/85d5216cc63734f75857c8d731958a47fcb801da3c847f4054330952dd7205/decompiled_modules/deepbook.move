module 0x2585d5216cc63734f75857c8d731958a47fcb801da3c847f4054330952dd7205::deepbook {
    struct DEEPBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPBOOK>(arg0, 6, b"DEEPBOOK", b"DeepBook on Sui", b"Gm to those who still gm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_1_f4fd2c1018.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPBOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPBOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

