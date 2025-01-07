module 0xab7bfbacf0b237490210f2cc1bf68dd79f19825f1c48e6109cafd08fb1155287::suimeme {
    struct SUIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEME>(arg0, 6, b"SUIMEME", b"Sui MEME", b"SURVIVE IN THE WORLD OF MEME WARS, BE BETTER AND FASTER THAN THE REST!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_07_162128_612e05a7e8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

