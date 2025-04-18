module 0x55f359e46aca3875b5d496b0bbd37f1f0fa9294323bf5918b57e07bc8593b668::wdg {
    struct WDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDG>(arg0, 9, b"WDG", b"WALDOGE", b"WDG COIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4bf60f2f091a2b81c54efe7ecbd95499blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

