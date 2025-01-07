module 0x8968934fefb737af9b0b703ab239be80f974bcd72ee3cf265340ba042b448537::swen {
    struct SWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEN>(arg0, 6, b"SWEN", b"SUI WEN", b"The cutest web3 memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731440096028.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

