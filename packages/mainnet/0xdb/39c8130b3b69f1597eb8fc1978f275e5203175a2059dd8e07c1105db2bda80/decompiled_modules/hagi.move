module 0xdb39c8130b3b69f1597eb8fc1978f275e5203175a2059dd8e07c1105db2bda80::hagi {
    struct HAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAGI>(arg0, 9, b"HAGI", b"Rahagi", b"Rahagi token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1465aa70-6544-4670-98d2-99172963ea66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

