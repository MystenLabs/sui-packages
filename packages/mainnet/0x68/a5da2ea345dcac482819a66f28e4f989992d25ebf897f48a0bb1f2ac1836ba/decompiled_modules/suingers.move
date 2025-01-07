module 0x68a5da2ea345dcac482819a66f28e4f989992d25ebf897f48a0bb1f2ac1836ba::suingers {
    struct SUINGERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINGERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINGERS>(arg0, 6, b"SUINGERS", b"SUI Swingers", b"Oh yeah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_06_222518_264cb66531.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINGERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINGERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

