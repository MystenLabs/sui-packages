module 0x41087fd66709829f8071f95f94058e68cbf4973870299bf9fd81fe1f56e97d18::paca {
    struct PACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACA>(arg0, 9, b"PACA", b"SUI PACA", b"$PACA - Let's make dumb money  https://pacacoin.xyz/  https://t.me/SUI_PACA  https://x.com/SUI_PACA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PACA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

