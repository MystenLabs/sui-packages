module 0x67f61cd33c182dda2e742e24e200d0169e4f1ce79108a3290707d7be6fd1468b::rhn {
    struct RHN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHN>(arg0, 9, b"RHN", b"Rohandante", b"Great dante", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/162a6544-af84-4f8e-943d-7515ec3837aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHN>>(v1);
    }

    // decompiled from Move bytecode v6
}

