module 0xf29644b770a735e5e49dba94a64c7d2a72978f72bd7763746855612731ed4f34::suifish {
    struct SUIFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFISH>(arg0, 6, b"Suifish", b"Fish on sui", b"Don't sell just hold I promise never lose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241018_203203_f72ec92e1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

