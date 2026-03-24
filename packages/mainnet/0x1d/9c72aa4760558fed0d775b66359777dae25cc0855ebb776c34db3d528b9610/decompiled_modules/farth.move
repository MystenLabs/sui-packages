module 0x1d9c72aa4760558fed0d775b66359777dae25cc0855ebb776c34db3d528b9610::farth {
    struct FARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<FARTH>(arg0, 6, b"FARTH", b"Fartcoin on sui", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRqQDAABXRUJQVlA4IJgDAACQFwCdASqAAIAAPm0ylkckIyIhKpYZeIANiWkAE6EyG/aA7+7azpP4dhoNS8oWoQVrVLqQg6QgO0JsBFYP43tDSPccvJMSpwp3fiFDXEWZCaNAPr5uIyNcykfDYXGgroRUiQlKeH7qHTMbMlSPDrJukMod82trfAhXfuoudZzjZJ2eo28IxbOFRiN2D2T7+qmoeCeS2GRhrSVkjMbbP/pXkaiO4rt3qKzKQJE+LM2ipGiIKTbfpL1bo30pdSEa+NUupCNMAAD+/EoAGjM3+h/im526H0V/bqpab4eIre/j/dkjK0MgvFBc73RPf7RfIHC7doHtMc4BXY75ULccG/gIsQYDLyCB5RE80c86SlizAUONVI/674PU2qYau8CCiHLlhrljdwb+WiKJixM8f33hGio3ZrAtZZPssIKa8LQ8GY/MFK4K1QhpfymuJd2GoMibHVKJeZ4meKLeZfuHDzqqy6IaaT9nI7oVDPTqgD27Pxkk0YSZ5I6PWddIADf5+aEwJW5w/CpEUKKHEzDflKyu3VL+r2emTmqPIixe4gjM9BowzPR5Qyl5eSGMC0bxLHHuaGS7t5HWKbq/KXf5lsOIIrfuUEmH36vcYCD8ww9dPcKxwCC0ZIaXC+0Noqv26O8AS33+TtXkOaEX79p+1ciGn2SCui6zE/IrkJrYzIbxMD3r9eVgoAy+tVdQZqNiGQ9tDkXlxRQ2eEl1ebSbqg0bfdHQwNlraCcuDnK/yEaPH4eoMnZdY1ZY+F2X01ykQaiAymqrqQkmVg9c6rOygbNraR9GvVvwGEUJZUweiGliQaW7owWcRhsvFK6VONrq4gkvrscYUKsuojnFnSbbjNAFD+yz6ZXbCCCv3yo5rXBABRiXAxqlGCntL1JhqFuCN1uCCL6n/bxq+TvlIucFmMLitYaWNA+xVPuDvmdm83nwH5dNNRrDnXHRuL6IjPOfjvA0sQPuVQBoiQ8U2KC6NlRcvssyzZZXENrnoSGu3wwz6GKYV0wR2C1gEUn0NNh8MvM08mNa9Z9JDrVFJcGWvSnANizSuvjvpADOtnwqVilrkZrI1eCUx6j+BudHortjLjctGiIxTq1hUtbRR5dnTMe0ZsuyrescyLqfyX6IzPJatyr/DldLJJwfrFdk8/+12thO/JRfte047jglY/lS63NH81w/JOkfRat1N/FmMuBJhWIW5ZPY17eSrPD0nUsatZt6cJEAAAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

