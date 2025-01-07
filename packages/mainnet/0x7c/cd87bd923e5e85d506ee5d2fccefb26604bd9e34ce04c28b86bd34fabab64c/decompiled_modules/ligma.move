module 0x7ccd87bd923e5e85d506ee5d2fccefb26604bd9e34ce04c28b86bd34fabab64c::ligma {
    struct LIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGMA>(arg0, 6, b"LIGMA", b"LIGMA NUTS", b"Ligma from the latin \"maNuts\" or referred as LIGMA NUTS. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731775263066.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIGMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

