module 0x52980e311e8543ce905cf61d9fc4c2cbd1fd678461f13ee9b02b9269c586f2ce::hczsnnnn {
    struct HCZSNNNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCZSNNNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCZSNNNN>(arg0, 9, b"Hczsnnnn", b"hczsnnn", b"my token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/597e5794c00f753fe426ad510c90dc98blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCZSNNNN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCZSNNNN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

