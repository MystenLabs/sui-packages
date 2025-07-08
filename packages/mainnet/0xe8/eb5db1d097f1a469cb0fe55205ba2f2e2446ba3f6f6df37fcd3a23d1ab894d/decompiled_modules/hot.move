module 0xe8eb5db1d097f1a469cb0fe55205ba2f2e2446ba3f6f6df37fcd3a23d1ab894d::hot {
    struct HOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<HOT>(arg0, 6, b"HOT", b"Hot", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRsgCAABXRUJQVlA4ILwCAAAwEQCdASqAAIAAPm02l0ekIyIhJxbZIIANiWMOxvzvUyOWbk2+Ge92HNhM7sA9ADpRf27LTi0eOguUrh3/ukAVhHlT5ljMnpCJpCEwCBqe9gxU2ZmXqPjLu7swdiHzMv4JSuqplQ9+BrOX6cWr1//+nBxWEXMip7NZgUkdZY9VReZFJV5Ed+qqkAGdTkXxmTBJwAD+/EoDgdUjjHxlMKuthhLknvEKAPJ8ymP8FTj/1/xzkYKRAh2uL8DuDsH7TDwiowB7MZuac7jdVZmZZBWwUhdnn1gugQ0BXu/m22ySReWygwQ9N6HSrCKqIBw6TVqxyr1kPz5MlRLjy2Xe9y+ta/FYYemMFPjex7vJkp9G73z/4rMOtI6ovcsxF2/qTxdqnQrYBnl/amNUH+0o2psqY2vgA3yShA+FypzAGsPvfs4NXuzxKphalfTr4+Vcw8KodPhBCWkBvyWL8gdEAEcwF9oUqI6qnMDskD1xPey7XR16ioGJORhokPO+usu3tDgGSBSeLuks+JnwoHr/caro1dNrfRYPw/0esz9js/ysfWrV+YqrN2YhJyjylnIbeOz7f5/kv76p/n7CDlf7j3F3jN/x9LKyZR+vXwynuzINrqMurh7KpU996G16LX8G4fxyGkukD1n9da3WZf+S/+MHLBpJ/+tYH9ZNEMpBXIG6oft+cA4vvWdC3bIhBgyMrgFGtoDd5zDnRzpvMwnA4BChnuSDcHuOnGU//ohpLW9dffSQRXZ/2R1tbq7brPrp+3lF5b+RX/sA/s5hvkBW4lEF/sA3QmaBeaP8DFrAJFzorjLxjEhYMeqGY+Gb64DVjT9yg8C9Z2lbViucn4sv8+NjZjjFAFJ2C++dMY+3n+d2pgVDZ3t71kCH9t9JI6qXpMxGWCXzKsB8lyj5C6GlcoQ0s3CiyoeDQ1GoAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

