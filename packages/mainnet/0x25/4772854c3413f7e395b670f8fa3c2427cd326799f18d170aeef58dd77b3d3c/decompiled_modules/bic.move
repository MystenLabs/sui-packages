module 0x254772854c3413f7e395b670f8fa3c2427cd326799f18d170aeef58dd77b3d3c::bic {
    struct BIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIC>(arg0, 9, b"BIC", b"Bia", b"Bi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74e3f039-fb63-4c5e-ace4-84e272dbe8cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

