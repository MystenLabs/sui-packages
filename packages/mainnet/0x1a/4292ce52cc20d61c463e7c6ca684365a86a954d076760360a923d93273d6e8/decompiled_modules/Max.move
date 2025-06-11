module 0x1a4292ce52cc20d61c463e7c6ca684365a86a954d076760360a923d93273d6e8::Max {
    struct MAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 9, b"MB", b"Max", b"Max buy is on. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/5816bb87-b32a-4429-b275-cb7461cec63e.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

