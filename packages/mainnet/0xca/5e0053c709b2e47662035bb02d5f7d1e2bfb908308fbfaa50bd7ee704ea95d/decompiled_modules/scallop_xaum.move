module 0xca5e0053c709b2e47662035bb02d5f7d1e2bfb908308fbfaa50bd7ee704ea95d::scallop_xaum {
    struct SCALLOP_XAUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_XAUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_XAUM>(arg0, 9, b"sXAUm", b"sXAUm", b"Scallop interest-bearing token for XAUm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dawtwhqvjcu3l37dzh2jmfffavm6pyyxfdl32lxu4727yeywkaoq.turbo-gateway.com/GC07HhVIqbXv48n0lhSlBVnn4xco170u9Of1_BMWUB0?")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_XAUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_XAUM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

