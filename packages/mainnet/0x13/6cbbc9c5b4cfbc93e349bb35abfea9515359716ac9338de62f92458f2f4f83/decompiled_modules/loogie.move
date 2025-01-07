module 0x136cbbc9c5b4cfbc93e349bb35abfea9515359716ac9338de62f92458f2f4f83::loogie {
    struct LOOGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOGIE>(arg0, 6, b"LOOGIE", b"Loogie on Sui", b"A big fat Hawk Tuah on the water chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_113242_dac5b7de9f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

