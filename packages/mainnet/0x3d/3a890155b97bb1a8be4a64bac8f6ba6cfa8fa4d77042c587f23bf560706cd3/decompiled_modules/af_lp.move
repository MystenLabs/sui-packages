module 0x3d3a890155b97bb1a8be4a64bac8f6ba6cfa8fa4d77042c587f23bf560706cd3::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF_LP>(arg0, 0xe058c19a59f6f079ca59f61ef17cef4cb1e21890a6fb85db9ca24aac20f18587::constants::lp_decimals(), b"afLP", b"afLP", b"The LP Coin underpinning Aftermath's afLP Vault", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/af-lp.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF_LP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF_LP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

