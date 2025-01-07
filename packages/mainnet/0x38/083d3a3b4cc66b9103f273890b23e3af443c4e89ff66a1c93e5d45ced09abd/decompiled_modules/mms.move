module 0x38083d3a3b4cc66b9103f273890b23e3af443c4e89ff66a1c93e5d45ced09abd::mms {
    struct MMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMS>(arg0, 6, b"MMS", b"mini mini sui", x"5765206275696c64696e672061206d66207375692067616e67200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_11_T174005_226_608a54938d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

