module 0xee755316de476c0224d1ce8e0876c90ff23bcd97617dcd140e96b2ab2c0d7fb::dwb {
    struct DWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWB>(arg0, 6, b"DWB", b"Dog Wif Box", b"DogWifBox moon, no doge moon DogWifBox moon today i s a DogWifBox da y toda i DogWifBox moon. yes DogWifBox go to da moon. u is cuming wif DogWifBox?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/redbull_41f022afc1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWB>>(v1);
    }

    // decompiled from Move bytecode v6
}

