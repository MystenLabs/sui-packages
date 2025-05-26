module 0xe18d24c93cc91e62ded9c6baa09322cc9ed1b006da9f1bf31aaef0698e301b53::ius_sui {
    struct IUS_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS_SUI>(arg0, 9, b"iusSUI", b"Ius Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRl4EAABXRUJQVlA4IFIEAADwFgCdASqAAIAAPm02l0gkIyKhJRmZ6IANiWkA1smnZwf8JyqXtRlOPz/CDsDbyxlrtjvQDSZY4vP9+kvO59CewZ+tXWA/cD2RCVfu6x7jf2l6rskTCKW7U0nNnUTlOKWn88PyLSqINCkREJtx2VmOpCEY0eZq6WmXCNdyijEhWhc17gluA/FyFklWAvO3mcLcs96MvgbBAb7rDhE2G8TgxjvqjON+Kgv1T44VjK9mxa/1so9bf0T5RnXabEdAD4AA/vvBK+DLbYqP6qp6+/QZB8CfV56vylVAtPNc7Vvfuksev1GUnsUKgRBrEzyGsLMLAfMrIWg9OGS1xDKn0E8+gHdz+wks02J0WfKSQhqcJXq3JDV8jOHD7Vfpri9mBQp3Ijs81jY2sd8pj5ravyqlCyFH5nAvsWyEFMbUxj5QHYp7cvFgBGNTAQaa/Py/O/t5LVt2jAP1Q40nsMQNhGtruhak2tV9gwserJeLuks+1eumU36P3MMhvYltDjV+CFPlU345t406l+j5XmgW3/8/lHKkfmn1+jd8H1RLKgpmK5sI9t6n/tjUI7XiCqqyVPSf5pI7YWeZOJJuZM0hE7MdY8wsY6JCGgDT9WzhltxlYQQ9BmsGh6E7Pz5H8KkECm4a6N/ZKzkbgNmVbHTaUvel3Zj/GKyJFYVRD+rvRuocZOQ3eAUVUPHRtlYA4FTdtY0Howv9jf+m4ZwZzgFmv9vpLYAqy9ix21JPo+P+i74zVRyRyQMvhZths93mqA4fnMNCKKnRthYN5NuSFQWh1faV4tiZZYof7fzc8FwJsgnNxxPonMEbaGXiEdMCSwYjpkepbfwQpWrqolubwtt22oPVf4fw3qpd9tJvkvTizwFrLscix5uUUBqaH+nxQ8Jkg46FCwRkT0NM/lyfJMV4/hl4j8Jmu4yXnJBvxAQQDH7ChIcQzdDMFfFTdqA4JlxK45jcchrKXRvqw4f8ID/8/2O7WyUjA23OjbY+5luXBlbqxg15B9LRsJMGaaWDHQrM4Sv6+F8ao02hrYsk2Y9qnYcr8D9r9hVOkemClBORqNCcFDsx5CSjWn86cQ8OvnWy+m2ozT4lSfW9hI7DGfX/CkW6sSzeBA3vI7O6MqtfV30CfL22zKEGoZx3zmPaOrXo19WXVWcL6UMkCbXPqEQVJufTMMgCiELeuwDieGBdYzg1POGOCDldzK8RXuG1i8PZKR5LCK7Noktt5CW/Y1kGcNBgDJNRqT4yQhM/tP23YDKQ03IBeDI9q5PBklaIRfHEMySrfRq93kHn3sXOGuCaCTY4hvWH2LtWTFywGcVe8sewPxFXiVSdHkh+EJ7FPlNJxi0dGXEzLPi+FMMm+H6cLacxN/M2Nhy6wJgeWBMSj084C9hPEMW7GYCQcRXWBnhIjgRmoAfa3VdYAsYJ/w8ND3zCYNxJpySCMgXjeiB6K/Z2xc3nR3aaWKNoe8lzmlgAAAAAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUS_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

