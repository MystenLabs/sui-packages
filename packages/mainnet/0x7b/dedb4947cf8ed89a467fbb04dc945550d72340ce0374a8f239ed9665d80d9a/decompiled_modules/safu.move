module 0x7bdedb4947cf8ed89a467fbb04dc945550d72340ce0374a8f239ed9665d80d9a::safu {
    struct SAFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFU>(arg0, 6, b"SAFU", b"Save you", b"It's safu token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/a64a7b81-db7a-4639-9220-17d265d21acf.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAFU>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

