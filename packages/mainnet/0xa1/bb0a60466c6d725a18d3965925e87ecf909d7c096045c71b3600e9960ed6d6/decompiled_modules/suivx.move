module 0xa1bb0a60466c6d725a18d3965925e87ecf909d7c096045c71b3600e9960ed6d6::suivx {
    struct SUIVX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVX>(arg0, 9, b"SUIVX", b"SUIV", b"GREAT SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/447b209c93a48526ed2f8064c41b2912blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIVX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

