module 0x954e240464e2953742f72cf94ca5dd770f2e1786fe8169a0f12898a09b065479::cola {
    struct COLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLA>(arg0, 9, b"COLA", b"CokeACola", b"Fast and rapid COLA, hop in!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1833407516031512576/bY1y3q5V.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COLA>(&mut v2, 800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

