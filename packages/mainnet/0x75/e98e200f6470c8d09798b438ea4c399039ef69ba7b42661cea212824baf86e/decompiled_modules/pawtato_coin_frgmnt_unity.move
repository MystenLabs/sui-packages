module 0x75e98e200f6470c8d09798b438ea4c399039ef69ba7b42661cea212824baf86e::pawtato_coin_frgmnt_unity {
    struct PAWTATO_COIN_FRGMNT_UNITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_UNITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_UNITY>(arg0, 9, b"FRGMT_UNITY", b"Pawtato Fragment of Unity", b"This fragment pulses with the lifeblood of Axoma itself. It binds roots to rivers, wind to flame, and spirit to soil - a reminder that every creature and element is part of one endless cycle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-unity.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_UNITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_UNITY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

