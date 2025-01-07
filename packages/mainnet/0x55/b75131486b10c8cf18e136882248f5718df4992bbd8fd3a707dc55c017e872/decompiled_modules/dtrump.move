module 0x55b75131486b10c8cf18e136882248f5718df4992bbd8fd3a707dc55c017e872::dtrump {
    struct DTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTRUMP>(arg0, 6, b"DTRUMP", b"Donuts Trump", b"The King Of SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_6_338a0dc443.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

