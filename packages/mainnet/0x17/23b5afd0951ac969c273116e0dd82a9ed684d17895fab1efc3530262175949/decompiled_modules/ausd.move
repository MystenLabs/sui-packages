module 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::ausd {
    struct AUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<AUSD>(arg0, 6, b"AUSD", b"AUSD", b"AUSD is a digital dollar issued by Agora", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://static.agora.finance/ausd-token-icon.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUSD>>(v2);
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::share<AUSD>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::setup::setup<AUSD>(v0, v1, arg1));
    }

    // decompiled from Move bytecode v6
}

