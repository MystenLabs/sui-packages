module 0xb7f2131b6dadca937386f1bb707f0322f545f7561238a399307361a786450099::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 9, b"NEMO", b"clownfish", b"Nemo is the clownfish. Thanks to Pixar and their blockbuster film from 2003, these much-loved creatures have become one of the most popular sights in the underwater world and are a delight to divers who come across them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca488c9b-baa8-482d-964c-50d9fbf0648e-1000002049.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

