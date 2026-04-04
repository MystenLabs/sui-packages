module 0xa3cdd72c6b5a700615c19400ec479b38847923f19f1d165fd620fea8c3e1f020::dunds {
    struct DUNDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUNDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<DUNDS>(arg0, 6, b"DUNDS", b"Diomands", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRvwBAABXRUJQVlA4IPABAAAwFgCdASqAAIAAPm00lEc/v6IhK5hYy/ANiWUA/gGvw114tOL9EU7nbk+YD//+n/5//p/+iFu7P6MfDN/uclJ8Qfw38J+1nygNP/G0JEN5tP+MwIA4IvS+jONsTjxJkGOabG6NUzk5noGY2m0zhi4xafp8xbiU910k/723XGrdg2sd0MGmC516b0mQTTVrNn5Dv4FptfNUB5GwufqCfwXPpbIftB0ER94oqjSpPCkQ8S2y7Uny9i+ZlgAA/vAqgr3G4z+XylOAACIoPC//Kr4JybCIqXlaf2B/ec9QV5YzZ/fhHc+5WB2SkgfN1kslCPvP01IsfGFFn/fnrdeU0oLq/eEhrNLQuyttJORXyybI9tEgy8joiNvqRU9vmc8/RuBcOvTtylUX7knD9+RZrJ2HxA0175VxyCuxlXLl7v81IdHw3l9CI+KdB46253Nvbue7vc6rr3eiMZGN0aFbSUV5sG21Wu2cxIEfAynN1WfIdQWHqSuxvGxgb87l1//k2cV9e2itorhHhoXyDvOnOq4yOxt1I2KQE/+Fcyjc7Y3s615pUAJpJiOBYxOKYakrSafkagBmaZl6eLzV2rq40k5fPNcLw6ckZpHfHKuiQiyOzSnsN10LndVCMTnFm8BTBfN0Xkk2p+jSPGZXQAAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUNDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUNDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

