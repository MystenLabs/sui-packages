module 0xc44391bb81fab5f1f9315d9572a9fdbf2a32666009f08bd8903773ada1251fc8::snad {
    struct SNAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAD>(arg0, 6, b"SNAD", b"Super Monad", b"Anonim project, dont buy this coin. Very dangerous, you will regret if you buy. Probably nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732065567119.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

