module 0x3ea78d700f82efac6e1c5e038daacd89cc5a79763e36589ea26e237ae829dbb3::eidi {
    struct EIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<EIDI>(arg0, 6, b"EIDI", b"Kidas Eidi", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRrwEAABXRUJQVlA4ILAEAADwFgCdASqAAIAAPm00l0gkIyIhJZXZ0IANiWMAVj77Db6c6rpve8634Bty9ayUFS9/m+HmWP+R8z+CH8TOY35vGhh6z9gnpOkUnm1ebvDTczYrHCAqLvGvNRBeA4V7piTtm0z0BTAPNF9hBO/VgzADBypSQOm/XTY++DyNT13bVldkx++ri/JPhhaQyvjwFnQvKawGv8dpN+RGajgPAZdGgR2O2rx+aej/apmkLlijKAnKV+vM7O7j60NdpsPQJyAA/vytEAznzP5x1cja/3LqyW8fc+jYsmW/k2P4YMcLMzhBO13LZHdrkrAXZUAShDumxTETgy/KGfL5MWQXP9JdlrQV2/+46cAVfJOO7D9G5AEdE/WipFKEHj1qWkA+Iu2fcQVDib57rsKS0QwpaBeovtnNlnvcb+o+Hz7JAjw4MVcGnKRtv2uqIlr5+0HcHa3EuK3iAgsQp/v0QSBjVZ4vgAvcVld8xw/ri6gEGxJ0WC5+are4VmlnrVdo1kDJ5nOSRue7A10sjnBJH237Z2YGCD6FxXspM62dNugqOrko46vt9OPYo8VRoe20qbatbUl6n1jbGeLtJp3Fq4qs59JTHejCbQAKKbH2jiZbivALpNZrKJ1pITfZf5oO4P6bWdzz9sWTa1oO5QS0Wdt6jtJdG7c6Dgq56T1n4TO9Qawd1H/BmSpdmHi9vdU97K4eZ4HqlJuNRBWUo40Ue8GFiJQUH2+BH54/uuSb5izwRAodOy0bWh5gWN6AFpMWVPKB3afLh3Q3X63VcG39QSJuAiPCjTwcEGogLSpwxhV3cUejbT+c9veFfUhJQolUS+68weXmX2IthuV/h3VUjtOZAcQrTHXWrNkoYT4fTz3r0gNQOvWqsdJdYcOjixzb/ZyBbQxoT+GgrFdIrXRWyUtvm5/Fc2mGxxiMmJ0xa9Tu0XA01QbBRLoSkjH1HfSfMfIBloYZkozkSE4d7lRghThGCj1rvEbnPjDbXE9Klgziqj5R4T4EF/PevqZxRQVUrbKuKjr0H7PWzUSPGT8yHAEnu9KE/6EiKGFWEXPwFZQWyuP9/Ad92eFgSG1iQ4ZTmViReo16ZvNmCsQ6G4nUbnmRP2idsXCCv2mWZ9KY2G4wRAwIpqD3bXKDn9r+BzF3Vw3oGvNKGrrBWQf/LdtrspcbDDWH1AndgtcF/bAzwFYMPykmHxNIgq4GXM2K+GSjEkV8pvGcCyMo/bxhM7aVz/M+L/bTedaZdxaXD1ZEod5hDo/yDqi4DgRjoBuVVD0ceMrBgb5/cZ2f+fzdrFvTUslB9Pb1/zABJxFYDMuFeg8aDqrTPIcGPIdCGDWXrVLkRYNaAYOUMl67zyoQIRDPr0fSZ4k9lxCnLcYjlH0wiabTl63SFTFf0gaui2Imo0ilk/sY90q+8ALpwqAUbEKjk8T/IjEsoJnHb+MfzTLiPh5k/RzvM/d96b7wlcHYSm9XGlXThblwmTuHj2vGio8JQcZKvmoD3V3MRSLQdn3bVKroOugV919vGhwhCZg+PhgUsMq5O+Q5A+BXIJyGj9Xiu72HJSneqG7B5sgXErkrlWb7CA6n+MFfB9iVkIoIVHd/6wAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

