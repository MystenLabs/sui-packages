module 0x5ecce85688adc57f7e12c683339c2bad668e275e072815cf5b989575e35b44e0::sl_sui {
    struct SL_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SL_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SL_SUI>(arg0, 9, b"slSUI", b"sl Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRgQDAABXRUJQVlA4IPgCAABQEQCdASqAAIAAPm02mEikIyKhJZRoUIANiWlu4XPhkK/4Dlsj8KKVal3QfuPmBpNZjPjN+nvYM/XLrI+i6MAbZ1Q6Ubm2YAz+y8fbQbAxo+jY+njfGk4xmTssrR8F9Pusvx45rIwIdmLVgYznLS6M5RDw3+PMcAgAS59MF7+UAgmd4xZKpi1+QVkI7WzAHc6oc4AA/v81hsIBdoktjhxVRB3Fgcxyk9+qoMeJjYhv5ka5MTPgh9Drif/gm4+fzp7X9SVNtTqzyBXfO2jM/JCYM4XF7lm13qCAhXHlW43yuLvv9abZNl8Y8fnLSc2pTqWgR9/pfa1KG7/IYxH+/jeQrmIAncg/OhuwlSFKxOqgiUF+7bLp+26zqOWHISvit6Sd+4G+wPwlJ3eHTGs7hRyzUrNTCF4GByOPfxOGOawf99rFgmJn4HXZjfzPzxdlXE3dgTjKLTm0nBVAFSYaQh2bX+UG1OTmn6EVBnmQ3qAKgcE35+5dcoF2yn8zvp8NBbmqqxtNdssuxt3BD13gHr5dhgNELJWRRf5axa6n8FF/wm3cFBvysrscABO2z35/onq/xR4WYcsj7jXbREqgZZtC2x+ms/JZ9rDgtrz0P347al65FH767iqSrpbxwI7uU32Nuk6GzCUf//lIUg94298DypRCkEASOMtPeJfLBVSXt2ev/tFqUkNwxWnvDww4XUX6gHURRssPy9gnW2ZqlYeDJ3K1lyQAqtsTwVidbbrydBTCjtv+Hgmtq942pLluHmbh8d/2lnMWQY5funVqmYQWER5MT5ZFl4zsF/YhDlvJMySqj2YhPmNMii2AO4+zq1G1syzBRY7/8z3MhVntzdtebjoqyQ2ZSVbg3DjffXRt/CVmY7Zu9DyArKQm0SRKZ/yspBYGrUQqGHae3y7pp5+Jni0/phHCLXQqKaTmzxdDHJ5hOWWr5kSfzWQzTzwJ+R2j9UrhIVg9xfRHMTVJPFDAYkdd2CAvAtRYhWE/jT97I36keD9AAAAA")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SL_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SL_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

