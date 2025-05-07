module 0xad7015540a794869ebabedb4e145e2fe94de452e23e8c265ef856ac102717d53::shill {
    struct SHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHILL>(arg0, 6, b"SHILL", b"shill", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGIAAAA0CAYAAABxcu3kAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAKNSURBVHhe7dc/SitBHMDx77wLCHoBSQ6Qxu0mrVkiWFnoESa1EMiWssLuAYxHyAUS2Hq2TJPCzkKs/XOEeZWLmbcPeWYf/sTfB6bI/HGRL0kmJoQQUF/uVzyhvoaGEEJDCKEhhNAQQmgIITSEEBpCCA0hhIYQQkMIoSGE0BBCaAghNIQQGkIIDSGEhhBCQwjRWYiyLEmSBGMMxhiSJGGxWMTbMMaQpmk83YjX67rGGENZls1cWZYYY6jrupmLtZ37SHwmTdPm/2kb//K3P9JJiCzLmE6nHB8f471nuVySJAkXFxdkWRZv/zaKosB7j/ce5xxA89p7z9nZWXzk0zoJMZ/Pcc6R5znWWsbjMTc3NzjnuL6+jrd/G4PBAGst1loODw8BmtfWWnq9Xnzk0zoJ8fr6Gk8BcHl5ifc+nlYtOgnhnGM+nzOZTLY+t3u9Htbarb0Az8/P1HXdOn6qTkJcXV0xm81YLBYMh0P29/c5Pz9ntVrFWwFYr9cMh8PW8VN1EuLg4IA8z3l5eWG5XOKcY71ec3Jy0npDGo1GhBBax0/VSYj3xuMxeZ5zf3/PbDajqqrWa6zatnOIzWZDmqZsNpt4iTzPAXh8fIyXVGTnEABVVVFVVTzdfPnu7e3FSyqyc4jBYIBzjul0ymQyYbVaUdc1WZZxenpKv9/v9IfPe3d3d3/cuuJ35sPDwx97RN7OQkdub2/D0dFRAAIQ+v1+cM6Fp6enrX1AGI1GW3Pvxeve+wCEoiiauaIomufE4+3s27m/jTZtz3rz9sz/xYSffFURZOePJtUNDSGEhhBCQwihIYTQEEJoCCE0hBAaQggNIYSGEEJDCKEhhNAQQmgIITSEEBpCCA0hhIYQ4je2qxD+HHG/NgAAAABJRU5ErkJggg==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

