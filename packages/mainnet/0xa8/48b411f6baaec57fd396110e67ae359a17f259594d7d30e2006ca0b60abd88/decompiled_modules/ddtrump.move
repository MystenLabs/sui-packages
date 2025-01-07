module 0xa848b411f6baaec57fd396110e67ae359a17f259594d7d30e2006ca0b60abd88::ddtrump {
    struct DDTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDTRUMP>(arg0, 9, b"DDTRUMP", b"Trump On Sui", b"DDTRUMP On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/f75baa2d11874d28f95644ce94d70feablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDTRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

