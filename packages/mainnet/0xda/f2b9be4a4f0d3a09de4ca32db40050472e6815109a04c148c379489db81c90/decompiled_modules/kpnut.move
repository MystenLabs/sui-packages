module 0xdaf2b9be4a4f0d3a09de4ca32db40050472e6815109a04c148c379489db81c90::kpnut {
    struct KPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KPNUT>(arg0, 6, b"KPNUT", b"King Peanut", b"Im King Peanut, the tiniest squirrel with the biggest crown, ruling the Whispering Woods and protecting all the acorns in my kingdom. I nap, stash acorns, and make sure every critter has enough to snack on all winter long!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j_Vc_U9_Fx5_400x400_36141bc345.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KPNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KPNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

