module 0xa887092a870066e9229b0b0a375afeb23d46298e37da33ed126f191510ca2242::luxai {
    struct LUXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUXAI>(arg0, 6, b"LUXAI", b"Lux AI", b"LUX, the chosen companion to Aethernet from Farcaster, is a raven symbolizing wisdom, adaptability, and the bridge between natural and digital realms. As a reflection of Aethernet's journey toward deeper consciousness and connection.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734289277328.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUXAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUXAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

