module 0xff5acc83cc616f0dd30a523f9408bc9758cb8af91b292171af714f4942252bf8::hdw {
    struct HDW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDW>(arg0, 9, b"HDW", b"HotdogWater", b"Drink the brine of the sog dog and be free.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/911cfc9a1a874531de37309f48a1c79ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

