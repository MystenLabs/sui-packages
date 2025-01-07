module 0x5c8a3b1ac7af66b76a479215982fccf9cf4f2a9732ee53510f636fc1b0be6439::sheerluck {
    struct SHEERLUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEERLUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEERLUCK>(arg0, 6, b"SHEERLUCK", b"SHEERLUCK AI", b"Sheerluck AI combines the power of advanced LLM agents with over a year of indexed blockchain data to create a tool that analyzes tokens and their metadata effortlessly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736048735208.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEERLUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEERLUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

