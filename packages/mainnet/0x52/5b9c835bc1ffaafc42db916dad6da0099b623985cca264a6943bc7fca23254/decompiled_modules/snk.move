module 0x525b9c835bc1ffaafc42db916dad6da0099b623985cca264a6943bc7fca23254::snk {
    struct SNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNK>(arg0, 9, b"SNK", b"OBAMASONIK", b"COOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f743f10717b9127466f4af1b4c0d9bdeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

