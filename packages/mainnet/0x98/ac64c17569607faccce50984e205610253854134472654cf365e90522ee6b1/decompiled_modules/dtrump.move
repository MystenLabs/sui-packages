module 0x98ac64c17569607faccce50984e205610253854134472654cf365e90522ee6b1::dtrump {
    struct DTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTRUMP>(arg0, 9, b"DTRUMP", b"PWEPWWE On Sui", b"PWECWWE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/e64c15ccf68c775a85d23b247d5d16d4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

