module 0xd5004115e0a0ccd7ea6fe768be6b0bec222e350e3fb0f7ad87eac187187b49d5::t2000 {
    struct T2000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T2000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<T2000>(arg0, 6, b"T2000", b"t2000.ai", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRgAEAABXRUJQVlA4IPQDAAAwFgCdASqAAIAAPm02mEikIyKhJRZocIANiWNu4XPpzfGAUd9bqxv1y/MB+gG+Af5L/Ada76AH6MeqN/wvZA/dD0laYqrP+UHe3tV7oTj3grRgSoIaT5APrL2CxOsNthtsNthtsNthsiff3mLe3RXsrdSbSdVau/dzhWP6OyzW+OF7zbCQjUX+KVXuALMoW+aQVSB7IFg+7khv0JoFxt6b8C7OWM1LHdZR9ybZEKj0OD23sI0bjbDbXgAA/v+PoFereaGhA2D8LR3q5935ybEW9MubWDQkQcYEuxpXu72EpxROWdEMQxWI/fdh/MtNXnF7eGJpvI8/aTUKV07Hj6XMf7P6NeCbvuagbOli5B83AdgxwdSeH4tK19yOR+OaQ6fx/ElZ+R13jRCZOU9tARRj9Zy38S0BAcDX2y/51echy/IP+jkQ+M+OEpPpryiz+0U/cto48C+Py0E6bsA8IO+i5pRru5ixkIu1/+TsFRD/nIErcZ7/BPhi3zNITw8bxjAtq8BNwqy6GdRn9RAVwSXcKREFvMke//SWSwXxPhgH4lb4FVdsZjlIIlNRdb4JAZIKx4Un4iMYecPl08qInGszgdhzpRTOQkYmXfcQZACXcSnlDov8OIYOVCx2VgN6f4vMWS1v/dzwNknf/Lhec0RPuwXKhF285CCsLL5Pw3lTdMYifcRD5lvbwPGhoVkkzVXyfbCTkcxnp1H/F403/XuQ+l3TC11vbH3WvWPMLSv7QCaJctBhWC8Z/eC4n/etWA9SrSf8ugpOF4vbbOPcj1/RsHgTOT4LexzlKVds7sTXmp9h54rWn9l+4zfOzD2SP1ZN8DF7hb7JGk2N1pJ+xvVN+OV5L5FcB/29ji+D7Tt7ou/jfPyapVy4pTPI7EQzKpT7Tf2Gal5TXoh+yqXPBfr4JRQRtZXw8k38RF4eQ90Fdr5Xwb9Jao/q6a/fIJfVPRGnYJgRs5x/FTA2lNyOXRLzv9/yB78893Z8I3XfzajUmhOtpTtUr3fwGUhVDGWwseSOXnbvapkYIZmygWX/GO1JDl/F7C0o8Q1oL/KbLteL5dYGFtwupOl9prCC2+TBRbEBGt/d3zSPVS+roubJNThMJm/2LyWYBrDN97gBewVYN7Ke7R1Bj0yLAYJ9gceAPfC+M7KAWTQtn6Vh8IlNfuk+s/7an9/T+QhBipJ8AhTJaVRMbkVVjOTtfRUSUzzlM+CHkq86vQKvezyI1yELns10UwELBQvrdCz+4H7cnMBOZvGABF7KMKRhdKuUbwv2xGVReeMYteP4HrrmZ8KkfMEpCadHRWX7PQ9G2dyrjctobEuO6/mc0kqH9ovRT9n87gAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T2000>>(v1);
    }

    // decompiled from Move bytecode v6
}

