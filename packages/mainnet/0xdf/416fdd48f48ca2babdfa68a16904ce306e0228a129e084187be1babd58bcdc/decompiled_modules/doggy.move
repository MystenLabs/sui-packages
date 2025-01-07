module 0xdf416fdd48f48ca2babdfa68a16904ce306e0228a129e084187be1babd58bcdc::doggy {
    struct DOGGY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGGY>, arg1: 0x2::coin::Coin<DOGGY>) {
        0x2::coin::burn<DOGGY>(arg0, arg1);
    }

    fun init(arg0: DOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGY>(arg0, 6, b"DOGGY", b"DOGGY", b"WOOF WOOF WOOF WOOF.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co.com/XksSvgN/photo-2024-10-15-19-41-09.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGGY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGGY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

