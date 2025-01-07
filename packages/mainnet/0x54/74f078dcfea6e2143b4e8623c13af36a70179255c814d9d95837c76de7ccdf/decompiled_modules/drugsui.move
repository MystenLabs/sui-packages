module 0x5474f078dcfea6e2143b4e8623c13af36a70179255c814d9d95837c76de7ccdf::drugsui {
    struct DRUGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRUGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRUGSUI>(arg0, 6, b"DRUGSUI", b"DrugSui", x"616c6c6f7720796f757273656c6620746f206c697665207468652062657374206c6966650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_11_T095855_146_7d9bc018f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRUGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRUGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

