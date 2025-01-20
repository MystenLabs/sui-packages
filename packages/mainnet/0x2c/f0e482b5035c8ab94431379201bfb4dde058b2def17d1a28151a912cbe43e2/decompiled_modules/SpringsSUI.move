module 0x632ae0f5031269e2192c0fc4e700edba8a014783ad00047ec4313c5c3d3062cd::SpringsSUI {
    struct SPRINGSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRINGSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRINGSSUI>(arg0, 9, b"sysSUI", b"SY Spring Staked SUI", b"SY Spring Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPRINGSSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRINGSSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

