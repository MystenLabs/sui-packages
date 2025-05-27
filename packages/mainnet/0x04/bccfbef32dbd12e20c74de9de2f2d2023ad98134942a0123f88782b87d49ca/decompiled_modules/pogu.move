module 0x4bccfbef32dbd12e20c74de9de2f2d2023ad98134942a0123f88782b87d49ca::pogu {
    struct POGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<POGU>(arg0, 6, b"POGU", b"pogU", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRtYEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBkAAAABDzD/ERFCTdsGTPiTDoaOI6L/SXzeD/EBAFZQOCCWBAAA8BsAnQEqgACAAD5tLpNFpCKhl8vdNEAGxLGAa4xYJhjVor3z8E3cR8+K8Vraz8o08EEWYxg+Vo/IkP35kZbFNjA7getYQsQazn2jY7cFeHyKiKlDL49C2ypsqoXQ2tsOvqsnUUtG2uruJE+rh0s+IUFGJ8HLiv2nwyxAs8BpUlPPq+DvTu31YItxlDqoiV1aV+68bYVxRBmRXjjJr3JmCOSRNfjSyacXoOfWRwSlSB1xYRZSGVtyHRI8Gir/J7wVvEPVFM9EQa40Vj4MzViomPX8oW14rhav+SIoNNP3cWvxRSXe3gjoIAD+/TZobW7///shp5KequYT//XE4eypovvBF9ecG3Q8dwTlob7XZ8dUMH97tFP8EVXhPb8yahhKBqdtQBgcQWaby7+wmTwRZN7Iz7bWauN/Ydax3/S7wLCn1Ze2B73U76cWodf0BuntXbnwL/1KDx41h/6NpJa0PlpHn0eaEw/zwlAsfEceEtfce19ESN5KdrllgIejXZv5TrOIAV1372JDDq62YaCorgN9il/IuA2VMmc9KSXlfhr1AiQCtqMRW3sfsNWuVuMsdnRZKIFKxHHP891Erupt5hNiTV/VfwkiX+VhVgLO+Z/vQbcZHTXr426xt6RqK3NhHG6Qwoxw06Omv6KrgkJpMBMonDR/XCZ/qPvCT0YEl9UunNsi8CjQ2sgGLKXyK9DfyBUGOXLDPoYh5SST5OCVQQdogYRgn2Iwk/n9SQbouHw7LSbfcYKogI7KgstCfR6Hw+4Au2kp6eXWJzuWxhRZL9xfwQIlw8vzzHvwYvb5UuZsY7cj9BTZL5YaKERFhD5Q4/LebHxfsV4ZSbfRMCiBQd435/hD+Qfv8v2bLy/i7Ui/0t150hqsch336zDpIkGmxPNEWABYCZ775H8n3zN9+277EzJAmrt/TPiqJSARxqQd3yCivViARgzz4ahhGS+6He7EGijMrSH2wpKbNwG5slCPI6gnjrTTC6X6zCW7hqhpaHYfPFJs4Xkd3Pr6qWtIlDrod/EiBVZgm+BaFpJC6LtVja09q6NwdsA7GwjxdAw88kJY7MWtGFJnRZd0cBEiZxxVCFGDHLbd+xAbOH/iJz9ylyxxlyBI+4N+rfn7gs95BaTy1Qp0i1UFTeiBw8UOgNRD688q6MyXBp4JH1do17rTjH7tOXtYdcaPlmp/ktLV+l1ZCDgB1Qzl2snKJaowa+hSrX1VLBP4PTYwH1amgADjfCI1iGuB9BbQi+k3L27yf29uMvrXcoH1FagK8qmrf0+VT9ipKtenNUIdNkDvrrBi0AcpAVtTKg9y1i+J6gRRcICu3zrUNWxyGz5x4gxeqvZ3n2Yppw+CyDIUynrkr5p0bWo9kIg/klenseQV2LTjqqXVwsdoVbXkUkn/ydsTKLM+C0ajrdu2g1OEBsJhH+YQoQ5I6qXkPs4V///7GgHKG5c5HHzv8eNKrnu0Idrp2C4yZr6gZFIh0De3taSFUCCFaHpmpIFc3Z1sE+ok0sndtBrjoFEDiAz39cMfdzRuf7vyMSDD/tZqfIi5ngHM8TUwAAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POGU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

