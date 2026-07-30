module 0x816d2856f70ab566eaf434e1df1e683e1797db8217d097440307683e507eb6::t4ced33eb {
    struct T4CED33EB has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<T4CED33EB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T4CED33EB>>(0x2::coin::mint<T4CED33EB>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: T4CED33EB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T4CED33EB>(arg0, 9, b"USDT ", b"USDT ", b"USDT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/52kjYb4y/Screen-Shot-2026-07-27-231117-321.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T4CED33EB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T4CED33EB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

