module 0x4abb5771451c72519ac05bddef6fe8e5d2b1e3f81bc0fb8139bf86039aa3760::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA>(arg0, 9, b"IKA", b"IKA Token", b"Ika Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/0666959b63c3339d4852184dda4e1f243276424d83af10b0e6997da7ead9c89d?width=64&height=64&fit=crop&quality=95&format=auto")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKA>>(0x2::coin::mint<IKA>(&mut v2, 3000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IKA>>(v2);
    }

    // decompiled from Move bytecode v6
}

