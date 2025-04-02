module 0x751bf7b85d2d402f4a6d762dea3fadd62038efadb5c245b4dfa9b8c744d8809::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 9, b"CHAD", b"Chadpole", b"Not your average tadpole. Chadpole is swole Af, chugs sea-atine, and might just get with your fisch. Launching on https://t.co/n34HKRIZqM with a trustmebro3000.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/04e626a001be2a51cb0508413526d7e3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

