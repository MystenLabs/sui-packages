module 0x8aaa9b31c7d3f78b042f03f7dcee287771e0807d4474dfb867206cea17a3963f::jak {
    struct JAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAK>(arg0, 6, b"JAK", b"Jak", x"244a414b207468652073696d706c6520646567656e207472616465720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y_Jw_Ec_DX_9_Wa_Cq_A4_WJ_Ac9t_B_Qvwug_D_Mkw_Da3_Bdbq_Fx_Bau_EE_9fdc65e628.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

