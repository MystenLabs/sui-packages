module 0x6ca04c79690b7e3722a8a7fa6055aa37dde0640d9fa313c75db54505be73e21a::binu {
    struct BINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINU>(arg0, 6, b"BINU", b"Baldo inu", b"Sui chain Meme Project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026206_831822e272.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

