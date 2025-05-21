module 0xde1973e167639c97fcd2bf83b35656b5534e29d320b60658ea28b9be7160414b::code2 {
    struct CODE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<CODE2>(arg0, 6, b"CODE2", b"code", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRkoFAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/ERFCTEPoX1oG80T0P9nDXOwCVlA4IA4FAAAwGwCdASqAAIAAPm02lUgkIyIhJZuZ0IANiWdu/Hx7AA6rRgbwOAftq+eA0xTeS/8/Xt33TwH8K3oLLCxX2gfTP8t5Od6e1nvZeS/4DxZfkfdSagXcbzTP834s3iDUAPyX/ivuS+lb+P/Z7zlfSPsHfqz1rvRRJCLUEjQUjQOOGNXm6uyY7DD/V+u5jOwov1wwW9k7cKrgxADzqn7MxQNOvNXHJ1e/05D4D9eAWDDNPd5GtW3tcF3oXw0x3dx8AXQ6q/GK17CMzu53Ot0UGmFSxPs8T/UHEn0KWgpGgccMau8AAP7VyYAKne3n5j8tAWTmClBl/lFNXwhBFDIfAHy2bJ2w0Ha/VWgVIfer1FV9lqvLKqwWww/wnDrCiGMVteRFaREX0t7UFhUrgRNADDJU+7npjtyiPo4jM+GGpEx/RaecOUsDUajwGZizjEAsx7XJqNBT4jWb1L0+ReBhf7gsjiMmW5+oP/gGYszLHvjc7iyVAratImbYKQFXNtTXwv8s06EpsHuZ494YmQ4DsUERqlTavWsElFzEETYsUmoEn8YgFpbltGhZZo+PUmx3zQ4b3/+ofrE/mwPkjVj2Pxcqzd2iAun5hnsuKvtzNTZMIdjPkPOtKWwx1Iyi8+YkUDqsVACY66d5K2fqtlci7bfW/Rm3YOaWLVCA/rkDf391deZZ6ZQvrFxtX2LuQB6+RilGUTv5zVBCuXEf4LCIJH5iaYWOV+G6hWZQs3/YGiS1YhPMxO2uRla4XebW+aIndUHTvc3Up2eIaOI1z4MraxlQnardRAd3j/TL3Q6RG03Ge43HEjXCRFleCEP4KyiFzDKxn/NfVEo19PfIIww5gBiJ5W/vdAYo44bTZ4UsSXEcvz2Av3nykCNVyd7AM6IXbDY23nvYYqrPQUVXrlNsw3eMQ6tavJOCko32X//4F2rYIG4Q/XOD5Lur3avrnf/gWC8u67VQvSVWeweq1BDPWo0vFoRpFNYBTxZFGetBTZM9G6jAsLuGsvLb87z4azJdeXuTtwDK8t+uqLGGAO+QnCOwP9Lobywr0IzhBsFltP96RQq1/dmf25DiBzLZZZS+CENFY4ey+Tk7x6y+I+kGsyh/w4uPZBe4gnjzE9vHZZsKj+qqxz/oY0eBjEqDfsA4vo6K/xC+y7eh3l3nVMoKdyexdaSn5jhccSu/QyIYFlPnwYjYKTRiXhhceiToOcaSyWfXIlt4kafOLgSN7xcZH8/PHlQuf9kYYRbQjxB9p404Z+KKGe+5c+Agh4fxkAuv4Fbmx8NEfrgGnzlV0N35pPsY+fuxeSRgvvH+7Z+uwyNr7aoybffsFxn1P93FRarcDI/+8fblxQxvXe+TOiErm3hVDF/7W/fO7C8kyI1sUeX/x/VTbxW1Emx9fygHQLugjaHDt13+WA7erHk5tWQ5Hii31HrPkqDxRv8aAj/4oL9lyEKWLAISzjhABxaS6LSNZ3fIs8iSk+/EIRvbqIEUldgbVsQn2ffx05ukkDfLbGK9d4mUpz7Zj1WxY3R5H8dlkieHQTgp3J7FranBQkNbmiYTCKtSDMoFu509guWY2EBYWz1qGR2zIvWFIq3VkEy/sQctLQufvi+WH0SnZp7s8r+o1iH9jwVpyzFdg9u/4/vukH/677x9xP3QyspszcNtLzXAqT+Xf/pXhcGsQMlFtsgjXgiG5JsewPix7BijnwGCJbju074PlTxZgAAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODE2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CODE2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

