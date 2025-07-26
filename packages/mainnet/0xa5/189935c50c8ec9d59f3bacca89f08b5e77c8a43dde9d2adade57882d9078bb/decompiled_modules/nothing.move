module 0xa5189935c50c8ec9d59f3bacca89f08b5e77c8a43dde9d2adade57882d9078bb::nothing {
    struct NOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<NOTHING>(arg0, 6, b"NOTHING", b"nothing", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRooDAABXRUJQVlA4IH4DAADQEgCdASqAAIAAPm02l0ikIyIhJhK4KIANiWlu4XPhkHf3Hov/Mh7j9q/KjRbf4Pe2sg/7bugPQDuLf8HrgH8u/rX6uewlnt+g/YJ/W7fKxhBf4Hc6pI+wjE/0EXbrtsINRm7UYxfHvXvPNRZync5mqe/HNHRQ54LkVbadsrC6HoEIBMcqelyy7pG0MAKBzjQFkDD9OwSzAHc6pI+wgwAA/v+WIAm9+CQSJeXiOifzZE6zuEun2Gk1Yuc8Moqoo2+sCul/ARBSH02LhDbhQK3r8I93gZVrXDLAumc7zVvHHW8H4a/+heIxjRcrtP6LEB7pwB6pBaoZ2uNvP2kCprltcRXD6Q9WD/5VV7FgZUBz2svlibf8L9zQeBjTAqo19j/BbOBWu/+bSi4ZchEC4zeOyZfI2pAukuyQz/w2/I6zf+JAaMMf+gHHzGhwkoYFuIrZscj/XolJDbzD+iUqfoWwAqu0Nj+jdIQFmH6zSB1qXjVnzpFvGqZ+MdJYipksn9BpLQmexPJ95JPXH4WvCuugTB37zR55eGUnq9ywBrouBpVkr2wZLqCz7d5jbjb7+Oqx/s2lbndDitNL4KWeiVh4YEca9dMSftzJAqYBHs2C32m4PAch5m3vppvOkVoFu9p/oj/oWr+2iav/7e5++UkAa6VJLMfJv5Lo4ljM5sDBi+pBvITaYZ63TMV/QudLijvcfaXzficOUUslHdiJMjB7cfnDWqmoLJyXLALS+b/XsfnIgru7QQfHdeAp7VeMW3iLVNMIRf/EPvDg6dDq/2zco20i3uivFbML2y3+iKXb4X8izi7FMTZL2R+1wH232UTkWVvtFaKef0ixYiHqEK32TDr93487NFFp5/wBT5wlZeCXJp5HwB6sM6d1aujVrl1V1z8+pE3vU+iApKEQ0tDaWaB7/q6QCjdIE8FCRq2ULi4rnXICb9vwv/yG5bLhLon/p9SoU6CPnLj1w7Iw+oOHKsMp7g7fNVtL3UTsPJx+wbkxjZBJ+E0ekb6vgTKtoAgKNYjoSco2dpOqBD8nIpmme4EdsSFT0h5kzYNXYyrlodQrZfRCpOd9P+E3qnhS57DERs9OthpgqDUi9UuUZvYyOI8bOiVLKfsv1DbXycOjsHzlR/lqMB3dqvy6gVxDjylTRLdLxizp3wqfd+gqv41avZ9E5btmVog0AAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTHING>>(v1);
    }

    // decompiled from Move bytecode v6
}

