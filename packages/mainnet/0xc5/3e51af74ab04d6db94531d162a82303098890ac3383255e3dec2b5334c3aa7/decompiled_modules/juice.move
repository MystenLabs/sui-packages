module 0xc53e51af74ab04d6db94531d162a82303098890ac3383255e3dec2b5334c3aa7::juice {
    struct JUICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUICE>(arg0, 9, b"JUICE", b"juice", b"orange juice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUICE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUICE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

